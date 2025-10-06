module 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::vault {
    struct Locker has store, key {
        id: 0x2::object::UID,
        coins: 0x2::balance::Balance<0x2::sui::SUI>,
        tokens: 0x2::balance::Balance<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>,
    }

    public(friend) fun add_coins_to_balance(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        0x2::balance::join<0x2::sui::SUI>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Locker>(arg0, locker_bag_index()).coins, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
    }

    public(friend) fun add_tokens_to_balance(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: 0x2::coin::Coin<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>) {
        0x2::balance::join<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Locker>(arg0, locker_bag_index()).tokens, 0x2::coin::into_balance<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(arg1));
    }

    fun locker_bag_index() : 0x1::string::String {
        0x1::string::utf8(b"vault_locker")
    }

    public(friend) fun send_coins_to_account(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Locker>(arg0, locker_bag_index()).coins, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u64(arg2)), arg3), arg1);
    }

    public(friend) fun send_coins_to_admin(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Locker>(arg0, locker_bag_index()).coins, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u64(arg1)), arg2), 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_admin(arg0));
    }

    public(friend) fun send_tokens_to_account(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: address, arg2: u256, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>>(0x2::coin::from_balance<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(0x2::balance::split<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Locker>(arg0, locker_bag_index()).tokens, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u64(arg2)), arg3), arg1);
    }

    public(friend) fun send_tokens_to_admin(arg0: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg1: u256, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>>(0x2::coin::from_balance<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(0x2::balance::split<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(&mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_value<Locker>(arg0, locker_bag_index()).tokens, 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::to_u64(arg1)), arg2), 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::get_admin(arg0));
    }

    entry fun setup(arg0: address, arg1: &mut 0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::Alpha, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 == 0x2::tx_context::sender(arg2), 13906834260242726911);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_admin(arg1, arg0);
        0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::validate_version(arg1);
        if (!0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::has_value(arg1, locker_bag_index())) {
            let v0 = Locker{
                id     : 0x2::object::new(arg2),
                coins  : 0x2::balance::zero<0x2::sui::SUI>(),
                tokens : 0x2::balance::zero<0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::kyovy::KYOVY>(),
            };
            0x55381feca1e94e6af05b8824c2a95f06d4a1cec9e388c50fbfcac25e3edea1b::alpha::add_value<Locker>(arg1, locker_bag_index(), v0);
        };
    }

    // decompiled from Move bytecode v6
}

