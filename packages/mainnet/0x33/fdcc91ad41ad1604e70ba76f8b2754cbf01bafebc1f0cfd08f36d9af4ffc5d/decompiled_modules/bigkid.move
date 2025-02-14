module 0x33fdcc91ad41ad1604e70ba76f8b2754cbf01bafebc1f0cfd08f36d9af4ffc5d::bigkid {
    struct BIGKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGKID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGKID>(arg0, 6, b"BIGKID", b"Big Kid", b"Big Kid (BKT) isn't just another token - it's your backstage pass to epic events. Every transaction fuels massive annual gatherings where YOU call the shots. As a holder, you're not just investing - you're producing unforgettable experiences.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739502682149.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIGKID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGKID>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

