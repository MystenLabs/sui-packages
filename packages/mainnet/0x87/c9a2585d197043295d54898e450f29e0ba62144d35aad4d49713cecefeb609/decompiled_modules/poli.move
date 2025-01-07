module 0x87c9a2585d197043295d54898e450f29e0ba62144d35aad4d49713cecefeb609::poli {
    struct POLI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POLI>(arg0, 6, b"POLI", b"Poli The Polar Bear", b"Embrace the SUI charm with $POLI, the polar bear, as he spreads good fortune and prosperity across the SUI network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9821582c_e733_45d4_9a4e_e44e172e4efb_f48f06f6cf.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POLI>>(v1);
    }

    // decompiled from Move bytecode v6
}

