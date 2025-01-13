module 0xcff25151a182227adcf59f46a11c5f1e21bcb0b2452b7ace2f79308a06a47638::yomomma {
    struct YOMOMMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOMOMMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOMOMMA>(arg0, 9, b"YOMOMMA", b"Your Mom", b"Your mom is a meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/54b75767ae0a1fbf6caebd8fc7ace462blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOMOMMA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOMOMMA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

