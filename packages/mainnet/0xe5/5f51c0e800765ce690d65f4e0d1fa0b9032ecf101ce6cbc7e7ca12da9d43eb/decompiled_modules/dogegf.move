module 0xe55f51c0e800765ce690d65f4e0d1fa0b9032ecf101ce6cbc7e7ca12da9d43eb::dogegf {
    struct DOGEGF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGEGF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGEGF>(arg0, 6, b"DOGEGF", b"DogeGF", x"5761726d2d6865617274656420636f6d6d756e697479206675656c656420627920746865206d61676963206f66207265636970726f636974792e0a4a6f696e207573206f6e206f757220616476656e74757265206f6620737072656164696e67206b696e646e65737320616e642066756e20746f67657468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4u_W_Ivkji_400x400_0fc8aff40c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGEGF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGEGF>>(v1);
    }

    // decompiled from Move bytecode v6
}

