module 0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::controller {
    public entry fun pause(arg0: &mut 0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(!0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::is_emergency(arg0), 202);
        assert!(0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::pause(arg0);
    }

    public entry fun resume(arg0: &mut 0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::Global, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::is_emergency(arg0), 203);
        assert!(0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::controller(arg0) == 0x2::tx_context::sender(arg1), 201);
        0x294d27ed37814e4de40298be2bab92d97ca0383cf6a20cea54a470bb7965e348::implements::resume(arg0);
    }

    // decompiled from Move bytecode v6
}

