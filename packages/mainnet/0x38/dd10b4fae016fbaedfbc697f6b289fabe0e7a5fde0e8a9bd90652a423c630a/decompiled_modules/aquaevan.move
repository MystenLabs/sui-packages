module 0x38dd10b4fae016fbaedfbc697f6b289fabe0e7a5fde0e8a9bd90652a423c630a::aquaevan {
    struct AQUAEVAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUAEVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUAEVAN>(arg0, 6, b"AQUAEVAN", b"AquaEvan", b"The Legendary Sea Warrior and Rightful King of The Sui Kingdom ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X8_Nsfd_EH_400x400_e7ed3f6814.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUAEVAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUAEVAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

