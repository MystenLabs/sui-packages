module 0x2544c81677de6967a9a1ce67bc9c35059e04110d4eec8f04b840465bec36c1df::botsvs {
    struct BOTSVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTSVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTSVS>(arg0, 6, b"BOTSvS", b"BUTTON WAR (Sui  vs SOL)", x"427574746f6e7761722069732061206d656d6520746f6b656e206372656174656420746f206675656c2074686520636f6d7065746974696f6e206265747765656e207468652053756920616e6420536f6c616e6120626c6f636b636861696e732e20497420696e636f72706f72617465732066756e2c20726976616c72792d64726976656e20656c656d656e74732c2077697468206d6173636f747320616e6420627574746f6e2d696e7370697265642076697375616c7320746172676574656420617420646567656e207472616465727320616e642063727970746f2066616e73210a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1732539762126_431163dd7f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTSVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOTSVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

