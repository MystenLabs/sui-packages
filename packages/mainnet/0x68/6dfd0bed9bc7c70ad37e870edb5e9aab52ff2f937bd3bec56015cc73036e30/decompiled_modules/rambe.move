module 0x686dfd0bed9bc7c70ad37e870edb5e9aab52ff2f937bd3bec56015cc73036e30::rambe {
    struct RAMBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAMBE>(arg0, 6, b"RAMBE", b"Taterambe", x"0a5461746520686172616d6265204953204a55535420545259494e47200a0a544f207472616465206f6e205355490a0a414e4420464f524d204120434f4d4d554e4954590a0a4f46204e455720465249454e445320414c4f4e4720544845200a0a5741592e204a4f494e205461746573204a4f55524e45592120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048551_43c0b4e0a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAMBE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAMBE>>(v1);
    }

    // decompiled from Move bytecode v6
}

