module 0x18ae21536b7e0e812419a08c002c323d33214914a123d739fda0e9ace8a85af4::kof {
    struct KOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOF>(arg0, 9, b"Kof", b"Kofkof", b"Kofs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOF>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOF>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

