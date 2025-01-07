module 0x78f145e192e2c95fc6b8357a97a7b9e5ec253ee797979d7efb00fe51d8248017::famgo {
    struct FAMGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FAMGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FAMGO>(arg0, 6, b"Famgo", b"Famgonba Sui", b"https://t.me/FamgonbaSui - https://www.dragonballzsui.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/34f7215cc8017b8bf436a9b575d777c3_removebg_preview_660242dce0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FAMGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FAMGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

