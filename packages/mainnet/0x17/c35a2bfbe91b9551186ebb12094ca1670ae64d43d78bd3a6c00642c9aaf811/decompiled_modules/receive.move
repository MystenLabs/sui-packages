module 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::receive {
    public fun receive<T0: store + key>(arg0: &mut 0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::MysticYeti, arg1: 0x2::transfer::Receiving<T0>) : T0 {
        assert!(0x1::type_name::get<T0>() != 0x1::type_name::get<0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::RevealData>(), 100);
        0xb07b09b016d28f989b6adda8069096da0c0a0ff6490f6e0866858c023b061bee::mystic_yeti::receive_and_return<T0>(arg0, arg1)
    }

    // decompiled from Move bytecode v6
}

