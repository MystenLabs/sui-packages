module 0x18791571ac9c01f33e362d20a26a86448624eddcb2278a783c52e0abdc3def6d::mabob {
    struct MABOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MABOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MABOB>(arg0, 9, b"Mabob", b"mamiaboob", b"best boob for mamia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7fe760f8315a33e94cd2c7b2d60d64ffblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MABOB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MABOB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

