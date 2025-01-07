module 0x5415e8c1703e5a5e09dc809560141c9a88c76f7453e59f7abc19fed30d4a4307::door {
    struct DOOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOR>(arg0, 9, b"Door", b"Closed Door", b"Open every closed door and LOOK behind", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d96c8d6b28272ed8c4c37ec11588ef59blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

