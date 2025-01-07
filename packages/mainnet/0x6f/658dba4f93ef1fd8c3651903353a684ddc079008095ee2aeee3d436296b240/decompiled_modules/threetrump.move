module 0x6f658dba4f93ef1fd8c3651903353a684ddc079008095ee2aeee3d436296b240::threetrump {
    struct THREETRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: THREETRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THREETRUMP>(arg0, 6, b"THREETRUMP", b"Three Trump", b"$3Trump and let him do what he wants without judgement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ppp_699d26cbd8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THREETRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THREETRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

