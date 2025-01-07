module 0xefa81da7a07df8a012aa062a7ece1678f2f7ac2f29c8f9e7fc93a35688879dac::ik {
    struct IK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IK>(arg0, 9, b"IK", b"Imran Khan ", b"Imran Ahmed Khan Niazi (born 5 October 1952) is a Pakistani politician and former cricketer who served as the 22nd prime minister of Pakistan from August 2018 until April 2022. He is the founder and former chairman of the political party Pakistan Tehreek-e-Insaf (PTI) from 1996 to 2023. He was the captain of the Pakistan national cricket team throughout the 1980s and early 1990s.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/44ba5c605e969c7d6fb324072382766ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

