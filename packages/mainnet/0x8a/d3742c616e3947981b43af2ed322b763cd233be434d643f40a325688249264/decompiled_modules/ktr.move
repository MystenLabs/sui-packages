module 0x8ad3742c616e3947981b43af2ed322b763cd233be434d643f40a325688249264::ktr {
    struct KTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KTR>(arg0, 6, b"KTR", b"Kitty Run", b"The Running Kitty on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kitty_6b527b3493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

