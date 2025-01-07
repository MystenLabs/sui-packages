module 0x61bb6367589ecc257f7b71853d3ef00861a10b4c8eb2dc670faab5abea4cf54f::blood {
    struct BLOOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOOD>(arg0, 6, b"BLOOD", b"Blood", x"446f6e2774206c657420796f75722077616c6c657420666c61746c696e6520776974682024424c4f4f446c65737320746f6b656e732e20496e667573652069742077697468207265616c2024424c4f4f4420616e6420776174636820796f75722070726f6669747320736b79726f636b6574210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A5p7i5_Us_400x400_dc690d383a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

