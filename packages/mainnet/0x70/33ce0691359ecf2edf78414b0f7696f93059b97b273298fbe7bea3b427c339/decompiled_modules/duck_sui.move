module 0x7033ce0691359ecf2edf78414b0f7696f93059b97b273298fbe7bea3b427c339::duck_sui {
    struct DUCK_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCK_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUCK_SUI>(arg0, 6, b"DUCKSUI", b"DUCKSUI", x"48656c6c6f20776f726c64f09f9189f09f91882c2049276d206d612064652064756b6572204455434b20535549494949494949f09f9696f09fa498f09fa499f09fa49b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://pbs.twimg.com/profile_images/1851844836858695680/p4JjmaAk_400x400.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DUCK_SUI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DUCK_SUI>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCK_SUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

