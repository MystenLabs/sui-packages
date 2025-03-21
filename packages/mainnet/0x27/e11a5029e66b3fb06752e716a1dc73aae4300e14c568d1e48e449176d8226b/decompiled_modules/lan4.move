module 0x27e11a5029e66b3fb06752e716a1dc73aae4300e14c568d1e48e449176d8226b::lan4 {
    struct LAN4 has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAN4, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAN4>(arg0, 9, b"LAN4", b"LAN004", b"004", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTQrpWWMsfc4pvmiVrJMF28VI9qF_iOcKXCTw&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LAN4>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAN4>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LAN4>>(v2);
    }

    // decompiled from Move bytecode v6
}

