module 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::graph {
    struct Graph has drop, store {
        layers: vector<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer>,
    }

    public fun add_layer(arg0: &mut Graph, arg1: 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer) {
        0x1::vector::push_back<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer>(&mut arg0.layers, arg1);
    }

    public fun get_layer_at(arg0: &Graph, arg1: u64) : &0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer {
        0x1::vector::borrow<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer>(&arg0.layers, arg1)
    }

    public fun get_layer_at_mut(arg0: &mut Graph, arg1: u64) : &mut 0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer {
        0x1::vector::borrow_mut<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer>(&mut arg0.layers, arg1)
    }

    public fun get_layer_count(arg0: &Graph) : u64 {
        0x1::vector::length<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer>(&arg0.layers)
    }

    public fun new_graph() : Graph {
        Graph{layers: 0x1::vector::empty<0x94055f1a652728cf156aa4cba7273d85911a54822a87b4a7b1df34311f65d62::layer::Layer>()}
    }

    // decompiled from Move bytecode v6
}

