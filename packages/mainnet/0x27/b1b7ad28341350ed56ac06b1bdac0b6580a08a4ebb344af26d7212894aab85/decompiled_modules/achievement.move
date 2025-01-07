module 0x27b1b7ad28341350ed56ac06b1bdac0b6580a08a4ebb344af26d7212894aab85::achievement {
    struct AchievementGrantCap has store, key {
        id: 0x2::object::UID,
        desc: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
    }

    struct Achievement has store, key {
        id: 0x2::object::UID,
        prize: 0x2::balance::Balance<0x2::sui::SUI>,
        owner: address,
        desc: 0x1::ascii::String,
        image_url: 0x1::ascii::String,
    }

    public entry fun create_achievement_grant(arg0: 0x1::ascii::String, arg1: 0x1::ascii::String, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = AchievementGrantCap{
            id        : 0x2::object::new(arg2),
            desc      : arg0,
            image_url : arg1,
        };
        0x2::transfer::public_transfer<AchievementGrantCap>(v0, 0x2::tx_context::sender(arg2));
    }

    public entry fun grant_achievement(arg0: &AchievementGrantCap, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = Achievement{
            id        : 0x2::object::new(arg3),
            prize     : 0x2::balance::zero<0x2::sui::SUI>(),
            owner     : arg2,
            desc      : arg0.desc,
            image_url : arg0.image_url,
        };
        0x2::balance::join<0x2::sui::SUI>(&mut v0.prize, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x2::transfer::public_transfer<Achievement>(v0, arg2);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public entry fun withdraw(arg0: &mut Achievement, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 1);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.prize) >= arg1, 2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.prize, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

