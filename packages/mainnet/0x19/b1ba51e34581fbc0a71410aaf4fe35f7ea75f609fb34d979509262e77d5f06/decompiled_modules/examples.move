module 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::examples {
    fun examples<T0>(arg0: 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::Cup<T0>) : T0 {
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::borrow<T0>(&arg0);
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::borrow_mut<T0>(&mut arg0);
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::value<T0>(arg0)
    }

    fun expanded_examples<T0>(arg0: 0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::Cup<T0>) : T0 {
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::borrow<T0>(&arg0);
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::borrow_mut<T0>(&mut arg0);
        0x19b1ba51e34581fbc0a71410aaf4fe35f7ea75f609fb34d979509262e77d5f06::cup::value<T0>(arg0)
    }

    // decompiled from Move bytecode v6
}

