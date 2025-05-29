module 0x1712cb8f9da06d83254907e6540429e894bc32903622696ea7d16f2db5c26df8::sfl {
    struct SFL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFL>(arg0, 9, b"SfL", b"SUI4LOVERS", b"Those who love sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0927a972be24116bbc59228d37efa1f6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SFL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

