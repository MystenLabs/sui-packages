module 0x27e28cee28f67e53bdfc7f222a2e2a1d02037b32423f81e6ca897cabbcf09739::haedal {
    struct HAEDAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAEDAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAEDAL>(arg0, 9, b"Haedal", b"Haedal Protocol", x"54686520756c74696d61746520706c61636520746f207374616b6520616e64206561726e206f6e2053756920f09f8c8a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5ee3a50b75501844ed4afe72f8972ad0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAEDAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAEDAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

