module 0x6fac9cacc57277964c9e19912e2cf853182f7108f9a2b7d4bc663dbd916a9084::tnt {
    struct TNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNT>(arg0, 6, b"TNT", b"TRINITROTOLUEN", b"Meme TNT is a meme coin inspired by the explosive and destructive power of TNT (explosive). It is not only a digital currency but also a symbol of breakthrough, speed and explosive potential in the crypto market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/2ff0cfa3-3044-4bb0-85d1-5f2daee83bfd.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TNT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

