module 0xcfcd4717a0402e89e346ec9cfe42866050e0a1e23561f6bbce6bdee842332c5b::dbsc {
    struct DBSC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DBSC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DBSC>(arg0, 6, b"DBSC", b"Don't buy shit coin", b"DONT BUY SHIT COIN because binance doesnt hold %34 and logo aint even loading    ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avarta_5302c80916.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DBSC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DBSC>>(v1);
    }

    // decompiled from Move bytecode v6
}

