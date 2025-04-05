module 0xac0d2b84a8338f8d4b697ab8062a9a8bc05de360c6e28729ce8adca9cdd7e92a::png {
    struct PNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNG>(arg0, 9, b"PNG", b"Rein Jer", b"It`s Rein JER Super ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e545ed49486c95b9bd0af80a32440b40blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

