module 0x9695e25cf035588f567a1760faf7cc613a41a0b59a7475327e18a4684709888f::sshib {
    struct SSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIB>(arg0, 6, b"SSHIB", b"Shiba Inu on SUI", b"Shiba Inu on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000558_0806fceda3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSHIB>>(v1);
    }

    // decompiled from Move bytecode v6
}

