module 0x266e06398f7ff97bf2605a9a2f5b463ed97ea60467a96edaaebd3911df1e5d89::prawn {
    struct PRAWN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRAWN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRAWN>(arg0, 6, b"Prawn", b"Pepe The King Prawn", b"The original Pepe, introduced in 1955 as part of the Muppets, has now united with Sui to reclaim his rightful throne. Behold, the reign of KING Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W_Wq_TL_8r_K_400x400_e18c50d441.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRAWN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRAWN>>(v1);
    }

    // decompiled from Move bytecode v6
}

