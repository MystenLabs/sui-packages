module 0xa79dfad8d515725ae262a3e32346d39ea474ead773f2eb0fb8d44354655dc171::wog {
    struct WOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOG>(arg0, 6, b"WOG", b"WORTOG", x"54686520666173746573742c2066756e6e696573742c2063656c65627269747920616e696d616c2e20574f472120574f47212120574f4721212120726576767676767373737320686973207637352063796c696e6465722e200a42726f20697320746865206b696e67206f662074686520736176616e616820616e64206d6f737420706f70756c617220616e696d616c206f6e20736f6369616c206d656469612e205374726f6e6b206d656d6520706f74656e7469616c200a574f474d6969696969696969696920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000268856_fe52960929.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

