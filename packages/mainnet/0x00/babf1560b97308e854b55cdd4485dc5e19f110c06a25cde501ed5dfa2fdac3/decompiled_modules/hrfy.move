module 0xbabf1560b97308e854b55cdd4485dc5e19f110c06a25cde501ed5dfa2fdac3::hrfy {
    struct HRFY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRFY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRFY>(arg0, 9, b"Hrfy", b"miyopi", b"cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b6c25cc60a6a257d7de4fb339945bbd2blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRFY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRFY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

