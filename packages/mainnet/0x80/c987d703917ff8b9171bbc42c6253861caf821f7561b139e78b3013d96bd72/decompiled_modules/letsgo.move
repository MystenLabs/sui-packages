module 0x80c987d703917ff8b9171bbc42c6253861caf821f7561b139e78b3013d96bd72::letsgo {
    struct LETSGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LETSGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LETSGO>(arg0, 6, b"Letsgo", b"Forceatous", b"sucezbien", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/11174e27_f1ea_4204_a361_a771f1f501ab_ec55048d81.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LETSGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LETSGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

