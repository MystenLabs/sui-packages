module 0x38c920ef8bce1c009b3fefd85578f5e3bdfe8557eb84298a93c0eb575400e210::spicex {
    struct SPICEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPICEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPICEX>(arg0, 9, b"SPICEX", b"SPICEX COIN", b"Trump and Musk united and developed $SPICEX Coin, which is official currency for interplanetary communities!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e9da6e88b53789038ce6d398bf0a08fablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPICEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPICEX>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

