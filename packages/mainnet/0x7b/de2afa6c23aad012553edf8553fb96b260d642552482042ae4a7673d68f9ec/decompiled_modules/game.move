module 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::game {
    struct Game<phantom T0> has key {
        id: 0x2::object::UID,
        version: u64,
        min_bet: u64,
        max_bet: u64,
        difficulties: vector<0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty>,
        balance: 0x2::balance::Balance<T0>,
        reward: 0x2::balance::Balance<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>,
        reward_ratio: u64,
    }

    struct GameOwnerCapability<phantom T0> has store, key {
        id: 0x2::object::UID,
    }

    public fun new<T0, T1: drop>(arg0: T1, arg1: u64, arg2: u64, arg3: vector<0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : GameOwnerCapability<T0> {
        assert!(0x2::types::is_one_time_witness<T1>(&arg0), 0);
        let v0 = Game<T0>{
            id           : 0x2::object::new(arg5),
            version      : 1,
            min_bet      : arg1,
            max_bet      : arg2,
            difficulties : arg3,
            balance      : 0x2::balance::zero<T0>(),
            reward       : 0x2::balance::zero<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>(),
            reward_ratio : arg4,
        };
        0x2::transfer::share_object<Game<T0>>(v0);
        GameOwnerCapability<T0>{id: 0x2::object::new(arg5)}
    }

    public fun difficulty<T0>(arg0: &Game<T0>, arg1: u64) : 0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty {
        *0x1::vector::borrow<0x7bde2afa6c23aad012553edf8553fb96b260d642552482042ae4a7673d68f9ec::difficulty::Difficulty>(&arg0.difficulties, arg1)
    }

    fun check_version<T0>(arg0: &Game<T0>) {
        assert!(arg0.version == 1, 1);
    }

    public(friend) fun incr_balance<T0>(arg0: &mut Game<T0>, arg1: 0x2::balance::Balance<T0>) {
        check_version<T0>(arg0);
        0x2::balance::join<T0>(&mut arg0.balance, arg1);
    }

    public entry fun inject<T0>(arg0: &mut Game<T0>, arg1: 0x2::coin::Coin<T0>) {
        check_version<T0>(arg0);
        0x2::coin::put<T0>(&mut arg0.balance, arg1);
    }

    public fun max_bet<T0>(arg0: &Game<T0>) : u64 {
        arg0.max_bet
    }

    entry fun migrate<T0>(arg0: &GameOwnerCapability<T0>, arg1: &mut Game<T0>) {
        assert!(arg1.version < 1, 2);
        arg1.version = 1;
    }

    public fun min_bet<T0>(arg0: &Game<T0>) : u64 {
        arg0.min_bet
    }

    public entry fun mint_reward<T0>(arg0: &mut 0x2::coin::TreasuryCap<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>, arg1: u64, arg2: &mut Game<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg2);
        0x2::coin::put<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>(&mut arg2.reward, 0x2::coin::mint<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>(arg0, arg1, arg3));
    }

    public(friend) fun reward_value<T0>(arg0: &Game<T0>, arg1: u64) : u64 {
        check_version<T0>(arg0);
        if (arg0.reward_ratio == 0 || arg1 == 0) {
            return 0
        };
        let v0 = arg1 * arg0.reward_ratio / 1000000000;
        if (v0 > 0x2::balance::value<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>(&arg0.reward)) {
            0x2::balance::value<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>(&arg0.reward)
        } else {
            v0
        }
    }

    public(friend) fun send_bonus<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg0.balance, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public(friend) fun send_reward<T0>(arg0: &mut Game<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg0);
        if (arg1 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>>(0x2::coin::take<0x1bb0b2e26444fe5bd939d105caa7113856633703f105314e19083808ba74f76a::swheel::SWHEEL>(&mut arg0.reward, arg1, arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw<T0>(arg0: &GameOwnerCapability<T0>, arg1: &mut Game<T0>, arg2: u64, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        check_version<T0>(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg1.balance, arg2, arg4), arg3);
    }

    // decompiled from Move bytecode v6
}

