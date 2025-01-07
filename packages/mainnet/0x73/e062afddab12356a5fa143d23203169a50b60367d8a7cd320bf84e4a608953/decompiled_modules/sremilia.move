module 0x73e062afddab12356a5fa143d23203169a50b60367d8a7cd320bf84e4a608953::sremilia {
    struct SREMILIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SREMILIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SREMILIA>(arg0, 6, b"Sremilia", b"Remilia", b"Remilia on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_Cxrr_MWUAA_Rtis_9e672e472e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SREMILIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SREMILIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

