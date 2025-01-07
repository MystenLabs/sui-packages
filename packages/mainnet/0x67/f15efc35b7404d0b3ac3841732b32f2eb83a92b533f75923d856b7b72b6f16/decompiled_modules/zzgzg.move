module 0x67f15efc35b7404d0b3ac3841732b32f2eb83a92b533f75923d856b7b72b6f16::zzgzg {
    struct ZZGZG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZZGZG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZZGZG>(arg0, 6, b"Zzgzg", b"dgdg", b"zgzgz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADA_2_93bed445b4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZZGZG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZZGZG>>(v1);
    }

    // decompiled from Move bytecode v6
}

