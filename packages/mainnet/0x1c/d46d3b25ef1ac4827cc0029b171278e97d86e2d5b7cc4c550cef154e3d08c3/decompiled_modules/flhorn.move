module 0x1cd46d3b25ef1ac4827cc0029b171278e97d86e2d5b7cc4c550cef154e3d08c3::flhorn {
    struct FLHORN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLHORN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLHORN>(arg0, 6, b"FLHORN", b"FLOWERHORN", x"24464c484f524e20697320746865206c75636b69657374206d656d652066697368206f6e207468652053554920626c6f636b636861696e2020200a426f726e20746f207377696d2c206275696c7420746f2070756d702e20200a41206d656d653f204d617962652e20200a41206d6f76656d656e743f204162736f6c7574656c792e0a0a536f6c616e6173206d656d6520736561736f6e206973206f7665722e20200a535549206e6f77206861732061206669736820696e207468652067616d652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_flhorn_259d6349d0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLHORN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLHORN>>(v1);
    }

    // decompiled from Move bytecode v6
}

