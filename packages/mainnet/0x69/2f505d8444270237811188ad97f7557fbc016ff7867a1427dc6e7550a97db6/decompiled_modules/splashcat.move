module 0x692f505d8444270237811188ad97f7557fbc016ff7867a1427dc6e7550a97db6::splashcat {
    struct SPLASHCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPLASHCAT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::BondingCurveStartCap<SPLASHCAT>>(0x9ade9d6efa73a07f19a0ea166dd6850dcd5cd8f1a25e868b302755e5386a0086::bonding_curve::create_bonding_curve<SPLASHCAT>(arg0, b"SplashCat", b"SplashCat SUI", x"4e6f74206a7573742061206d656d652c206974277320612077686f6c65207061636b206f6620617765736f6d6521204a6f696e207468652066756e20616e64206c657427732074616b6520746869732070757020746f20746865206d6f6f6e2120f09f9a80202353706c61736843617420234d656d65436f696e2023436f6d6d756e697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qma4WPiVzgnWYueB8khP9CUsB3XB1LGh5BY4UGNmPGUwxd")), b"WEBSITE", b"https://x.com/SplashCat_CTO", b"DISCORD", b"t.me/Cat_Splash_Sui", 0x1::string::utf8(b"00a0e80a7e044cf3871454d2af1b3b50044e27a41151f031be204db371d9c0670cc89347d83f1a2b9979a79e469778981c915a14961338c107a09900328260600dd598785fb33e7cb9fefbf2f413c86f72ed5a2ced9d71a6a840dd9d6eb9c2561c1747835942"), arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

