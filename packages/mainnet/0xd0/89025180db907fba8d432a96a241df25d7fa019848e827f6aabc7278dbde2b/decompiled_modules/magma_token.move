module 0x4d5c4c6ebd49c41afc675f585be0f0aae02771bd86c73a20ae22664ecb093293::magma_token {
    public entry fun burn<T0>(arg0: &mut 0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::MinterCap<T0>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::burn<T0>(arg0, arg1);
    }

    public entry fun mint<T0>(arg0: &mut 0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::MinterCap<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x7161c6c6bb65f852797c8f7f5c4f8d57adaf796e1b840921f9e23fabeadfd54e::magma::mint<T0>(arg0, arg1, arg2, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

