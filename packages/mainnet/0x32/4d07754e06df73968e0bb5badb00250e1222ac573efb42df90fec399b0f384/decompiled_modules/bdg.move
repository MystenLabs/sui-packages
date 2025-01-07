module 0x324d07754e06df73968e0bb5badb00250e1222ac573efb42df90fec399b0f384::bdg {
    struct BDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDG>(arg0, 6, b"BDG", b"Balloondog", b"Prepare yourself for something different", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Lovepik_com_361533475_3d_illustration_of_a_balloon_made_blue_pooch_85d1946679.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

