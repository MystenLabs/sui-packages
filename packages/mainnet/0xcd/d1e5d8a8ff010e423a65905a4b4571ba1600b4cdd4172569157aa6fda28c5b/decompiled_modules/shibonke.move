module 0xcdd1e5d8a8ff010e423a65905a4b4571ba1600b4cdd4172569157aa6fda28c5b::shibonke {
    struct SHIBONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIBONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIBONKE>(arg0, 6, b"ShiBonke", b"Shi Bonke on Sui", b"Shi Bonke on Sui is the real kung fu Bonke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Best_Animation_Movie_Characters_32_4138528596_b56d7433da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIBONKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHIBONKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

