module 0xfd74578d74870fd725748d006306ed327dfa4251984feda6039c42419e057e5::isekai {
    struct ISEKAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISEKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISEKAI>(arg0, 3, b"ISEKAI", b"Suicide Squad", b"Deadly crazy party of the Super-Villains land themselves in ISEKAI!!! The most dangerous & bizarre fantasy adventure unveiled....!!! https://wwws.warnerbros.co.jp/suicidesquad-isekai/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://preview.redd.it/any-opinion-so-far-regarding-suicide-squad-isekai-v0-7hgloiq6379d1.jpeg?width=1080&crop=smart&auto=webp&s=8a1e6080b38e3726006551dd626506f02d5d4a5f")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ISEKAI>(&mut v2, 200000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISEKAI>>(v2, @0x5c9bb147d9ed48100b208a900ab1f8777035fd303522c941d06d5fbc25d68021);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISEKAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

