module 0x3c998371cf7b4885e583d108abe4804aa8ee05ad5093e42836702dbfd2197c60::garu {
    struct GARU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GARU>(arg0, 6, b"GARU", b"GREGARU", b"GREGARU SATOSHI HBO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dubo_fwog_gm_ce58a74a5d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GARU>>(v1);
    }

    // decompiled from Move bytecode v6
}

