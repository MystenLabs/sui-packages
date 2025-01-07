module 0xac6fff74ee5ff8c00e5589038231b5a2d162234a3dfde814505847ae637ecaf7::dwg {
    struct DWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DWG>(arg0, 6, b"DWG", b"Dogwifgills", b"Just like the original dogwifhat but this time he took his hat off and evolved into a dog with gills!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Capture9_89c8fac480.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

