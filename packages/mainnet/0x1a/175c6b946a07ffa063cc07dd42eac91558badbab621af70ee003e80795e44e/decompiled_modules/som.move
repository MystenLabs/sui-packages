module 0x1a175c6b946a07ffa063cc07dd42eac91558badbab621af70ee003e80795e44e::som {
    struct SOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOM>(arg0, 6, b"SOM", b"Som Brokshear", b"Move of Creator, Som-founder, working on SuiNetwork.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/f79548cc_7414_4564_819f_e8039a52e8af_ed095f7d68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

