module 0x682ef0f23ee645c88460808b6230772a9f15ea05d6adf6025ed07cbd99806763::Winter_Is_Coming {
    struct WINTER_IS_COMING has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTER_IS_COMING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTER_IS_COMING>(arg0, 9, b"WINTER", b"Winter Is Coming", b"winter is cuming", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/Gz5slsxbsAACHQv?format=jpg&name=4096x4096")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WINTER_IS_COMING>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTER_IS_COMING>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

