module 0x2ab9c29fbec5a5b09b8736acfd6c4af73d1eb1776d7a4eb68f59e375cd2354aa::avtr {
    struct AVTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVTR>(arg0, 6, b"AVTR", b"AVATAR", b"AvatarSui the Last Airbender in Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000197783_16d08fdd3f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

