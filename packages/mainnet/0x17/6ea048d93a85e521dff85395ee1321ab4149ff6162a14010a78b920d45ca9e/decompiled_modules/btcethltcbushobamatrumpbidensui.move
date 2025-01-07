module 0x176ea048d93a85e521dff85395ee1321ab4149ff6162a14010a78b920d45ca9e::btcethltcbushobamatrumpbidensui {
    struct BTCETHLTCBUSHOBAMATRUMPBIDENSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCETHLTCBUSHOBAMATRUMPBIDENSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCETHLTCBUSHOBAMATRUMPBIDENSUI>(arg0, 0, b"btcethltcbushobamatrumpbidensui", b"btcethltcbushobamatrumpbidensui", b"https://t.me/btcethltcbushobamatrump http://btcethltcbushobamatrumpbidensui.xyz/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BTCETHLTCBUSHOBAMATRUMPBIDENSUI>(&mut v2, 150, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCETHLTCBUSHOBAMATRUMPBIDENSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCETHLTCBUSHOBAMATRUMPBIDENSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

