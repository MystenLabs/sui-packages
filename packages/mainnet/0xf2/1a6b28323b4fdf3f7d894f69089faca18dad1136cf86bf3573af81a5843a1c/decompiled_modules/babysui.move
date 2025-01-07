module 0xf21a6b28323b4fdf3f7d894f69089faca18dad1136cf86bf3573af81a5843a1c::babysui {
    struct BABYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSUI>(arg0, 3, b"BabySui", b"BSUI", b"https://t.me/BabySUI_TG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/4gKR9Bk.png"))), arg1);
        let v2 = v0;
        let v3 = @0x942e04899dc9ade6504873058c6a8f491ce7e2b76677008efd263d635dae452;
        0x2::coin::mint_and_transfer<BABYSUI>(&mut v2, 100000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSUI>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

