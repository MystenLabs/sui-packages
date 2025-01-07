module 0xeef7f2455262069c4c44ef4e74becba078c7c2b756fc4fb56a27bbfd1a9c4373::asadrun {
    struct ASADRUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASADRUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASADRUN>(arg0, 6, b"ASADRUN", b"ASAD RUN", b"The token is dedicated to the disgrace of Bashar al-Assad fleeing from Syria from fate and Allah", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/as_0e3dda1776.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASADRUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASADRUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

