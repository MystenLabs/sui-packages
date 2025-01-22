module 0x46edc13f4ff05398d7d7e7ed7363ec9521fbe9d0071c339391a2a4a072e01b5b::dol {
    struct DOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOL>(arg0, 9, b"DOL", b"just buy $1 worth of this coin", b"Just buy it for 1 dollar, suddenly it turns into a million", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7921ee1599bdfbfc22d911756c3ef6f6blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

