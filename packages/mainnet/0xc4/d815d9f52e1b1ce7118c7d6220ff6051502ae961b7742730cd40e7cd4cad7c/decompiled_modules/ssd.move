module 0xc4d815d9f52e1b1ce7118c7d6220ff6051502ae961b7742730cd40e7cd4cad7c::ssd {
    struct SSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSD>(arg0, 6, b"SSD", b"SmileShibaDog", b"https://x.com/puppiesDoglover/status/1834902534521082081", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Xcn_EC_7bw_AMQ_Yne_d359c4be95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

