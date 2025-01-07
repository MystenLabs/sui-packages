module 0x94686fd87b3313c9ba9d9bb5ad641567f715623e286f2eb16330efd632047166::suibaby {
    struct SUIBABY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBABY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBABY>(arg0, 6, b"SUIBABY", b"Sui Baby", b"Sui Baby is the baby of the Sui network, born in the deep waters of Sui and ready to grow strong. Fresh from the seas, this little token has big ambitions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_48_33a3d65a57.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBABY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBABY>>(v1);
    }

    // decompiled from Move bytecode v6
}

