module 0xd4705d3cea22dab71129f065c2f76e5d3a492a22bb71b9654dd8393757a22704::ptgr {
    struct PTGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PTGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PTGR>(arg0, 9, b"PTGR", b"Petigru", b"PTGR token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/22cfb309253f9e42fc88a4980f5e9d4fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PTGR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PTGR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

