module 0xb5ed6370b95227f49c034dd33f00e4155fcd486eec2b629501ac15685de6eb80::CNMUSK {
    struct PublicRedEnvelope has store, key {
        id: 0x2::object::UID,
        coins: 0x2::table_vec::TableVec<0x2::coin::Coin<CNMUSK>>,
    }

    struct CNMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNMUSK>(arg0, 2, b"CNMUSK", b"Chinese Musk", b"Hi,I'm chinese musk!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://inews.gtimg.com/newsapp_bt/0/14891223681/641")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNMUSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNMUSK>>(v0, 0x2::tx_context::sender(arg1));
        let v2 = PublicRedEnvelope{
            id    : 0x2::object::new(arg1),
            coins : 0x2::table_vec::empty<0x2::coin::Coin<CNMUSK>>(arg1),
        };
        0x2::transfer::share_object<PublicRedEnvelope>(v2);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CNMUSK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CNMUSK>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

