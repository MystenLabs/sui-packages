module 0xca1114fc0adf5d160d8a10d659246d9bd0f33a41b68640971e2ead1e08ad2fb0::wongirengjembuten635 {
    struct WONGIRENGJEMBUTEN635 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WONGIRENGJEMBUTEN635, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WONGIRENGJEMBUTEN635>(arg0, 6, b"Wongirengjembuten635", b"SUILIT", b"Powered by Wong Silite Ireng: A crypto token thats as bold as its name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_21_17_36_c5fc1ed5bb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WONGIRENGJEMBUTEN635>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WONGIRENGJEMBUTEN635>>(v1);
    }

    // decompiled from Move bytecode v6
}

