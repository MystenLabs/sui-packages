module 0x83e06d9235e138336533705b5aba2447d15d514bc3d96ab380f05eed36861112::t_t {
    struct T_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<T_T>(arg0, 9, b"T_T", b"T_T Face", b"T_T Face is a memecoin that indicates tears streaming from the eyes. It's a type of kaomoji. Let's support $T_T !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a584b347f860bf98bb07faab3494f8d6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T_T>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T_T>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

