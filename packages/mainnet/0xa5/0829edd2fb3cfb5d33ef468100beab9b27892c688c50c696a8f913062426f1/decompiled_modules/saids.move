module 0xa50829edd2fb3cfb5d33ef468100beab9b27892c688c50c696a8f913062426f1::saids {
    struct SAIDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIDS>(arg0, 6, b"SAIDS", b"SUI Aids", b"SUI Aids is a dedicated platform aimed at supporting individuals living with AIDS and promoting the celebration of AIDS Day", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_30_23_27_19_89c4cfb9f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAIDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

