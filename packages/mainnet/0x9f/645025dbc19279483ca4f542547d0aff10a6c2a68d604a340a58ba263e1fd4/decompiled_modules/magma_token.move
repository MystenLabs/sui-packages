module 0x5b9428ad212672a6ef8404569ae79de723610993579996e0fc2ae7e1665fd1f5::magma_token {
    public entry fun burn<T0>(arg0: &mut 0x5df88eb4e78f647daf4a5326ea529fe6d94612062effed4a6804d7511d268261::magma::MinterCap<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x5df88eb4e78f647daf4a5326ea529fe6d94612062effed4a6804d7511d268261::magma::burn<T0>(arg0, arg1);
    }

    public entry fun mint<T0>(arg0: &mut 0x5df88eb4e78f647daf4a5326ea529fe6d94612062effed4a6804d7511d268261::magma::MinterCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x5df88eb4e78f647daf4a5326ea529fe6d94612062effed4a6804d7511d268261::magma::mint<T0>(arg0, arg1, arg2, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

