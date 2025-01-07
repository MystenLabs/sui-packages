module 0x325fe410342259d6ec6a8a96f5ccb67835df21a4baf84d4618443f08c7d95cb2::biscuits {
    struct BISCUITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BISCUITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BISCUITS>(arg0, 6, b"BISCUITS", b"First biscuits on SUI", b"Biscuits the seal is a baby seal who was rescued in August 2024 by the Virginia Marine Mammal Rescue Society after being separated from her mother. Her quirky, sad-eyed expression and playful nature quickly captured the hearts of viewers, leading to her viral fame.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X2_PHB_8z7_400x400_80df2e20da.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BISCUITS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BISCUITS>>(v1);
    }

    // decompiled from Move bytecode v6
}

